import 'dotenv/config';

import sql from 'mariadb';

import { runTestSuite } from './util';
import { PrismaClient } from '@prisma/client';
import { writeFileSync } from 'fs';

const pool = sql.createPool({
    host: process.env.SQL_HOST,
    user: process.env.SQL_USER,
    password: process.env.SQL_PASSWORD,
    database: process.env.SQL_DATABASE,
    connectionLimit: 5
});

const client = new PrismaClient();

const run = async () => {
    let connection = await pool.getConnection();
    let rows = await connection.query(`
        SELECT
            l.Book_id, l.Branch_id, l.Card_no, l.Date_out, l.Due_date,
            b.Title, b.Publisher_name
        FROM Book_Loans l
        INNER JOIN Borrower u
            ON l.Card_no = u.Card_no
        INNER JOIN Book b
            ON l.Book_id = b.Book_id
        WHERE u.Name="Ramesh Narayan";
    `);

    let matched = await Promise.all(rows.map(async (row: any) => {
        let book = await client.book.findUnique({ where: { book_id: row.Book_id } });
        if (!book) {
            console.warn(`No match for Book ${row.Book_id} in Mongo!`);
            return null;
        }

        return {
            ...row,
            image: book.image
        };
    }));

    console.log(matched);

    for (let ent of matched) {
        let { Book_id: id, image } = ent;
        if (!image) continue;

        let buf = Buffer.from(image, 'base64');
        let path = `./covers/${id}.jpg`;
        console.log(`Writing ${path}`);
        writeFileSync(path, buf);
    }

    console.log('Done.');
    process.exit(0);
}

runTestSuite(run, [client.$disconnect]);