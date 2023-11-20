import 'dotenv/config';

import sql from 'mariadb';

import { runTestSuite } from './util';
import { PrismaClient } from '@prisma/client';

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
    let rows = await connection.query(`SELECT * FROM Book_Copies;`);

    const books = await client.book.findMany();
    const prices = books
        .map(book => book.description as any)
        .map(json => ({
            id: json.id,
            amount: parseFloat(json.format?.paperback?.substring(1)) ?? 0
        }));

    const branchBooks = rows.map((row: any) => {
        const price = prices.find(price => price.id === row.Book_id);
        if (!price) return NaN;
        return {
            branchId: row.Branch_id,
            bookId: row.Book_id,
            investment: price.amount * row.No_of_copies
        }
    });

    let branches = branchBooks.reduce((acc: any, curr: any) => {
        if (!acc[curr.branchId]) acc[curr.branchId] = 0;
        acc[curr.branchId] += Math.round(curr.investment * 100) / 100;
        return acc;
    }, {});

    console.table(branches);
    process.exit(0);
}

runTestSuite(run, [client.$disconnect]);