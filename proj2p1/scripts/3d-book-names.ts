import { PrismaClient } from '@prisma/client';
import { runTestSuite } from './util';

const client = new PrismaClient();

const run = async () => {
    // get name of the book that has no image
    let books = await client.book.findMany({
        select: { name: true }
    });

    console.table(books);
};

runTestSuite(run, client);