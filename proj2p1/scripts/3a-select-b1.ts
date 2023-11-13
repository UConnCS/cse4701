import { PrismaClient } from '@prisma/client';
import { runTestSuite } from './util';

const client = new PrismaClient();

const run = async () => {
    let book = await client.book.findUnique({
        where: { book_id: 'B1' }
    });

    console.log(book);
};

runTestSuite(run, client);