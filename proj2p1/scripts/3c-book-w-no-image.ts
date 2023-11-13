import { PrismaClient } from '@prisma/client';
import { runTestSuite } from './util';

const client = new PrismaClient();

const run = async () => {
    // get name of the book that has no image
    let book = await client.book.findFirst({
        where: { image: undefined },
        select: { name: true }
    });

    console.log('Book with no image:', book);
};

runTestSuite(run, client);