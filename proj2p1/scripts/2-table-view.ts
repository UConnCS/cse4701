import { PrismaClient } from '@prisma/client';
import { runTestSuite } from './util';

const client = new PrismaClient();

const run = async () => {
    let books = await client.book.findMany({});

    // only print the first 10 bytes of the image
    books = books.map(book => ({ ...book, image: book.image?.slice(0, 10) })) as any;

    // stringify the JSON object
    books = books.map(book => ({ ...book, description: JSON.stringify(book.description) }));

    console.table(books);

    // print how many key-value pairs are in the database
    let count = await client.book.count({});
    console.log('Total records:', count);
};

runTestSuite(run, client);