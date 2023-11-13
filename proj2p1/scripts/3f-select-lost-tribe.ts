import { runTestSuite } from './util';
import { PrismaClient } from '@prisma/client';

const client = new PrismaClient();

const run = async () => {
    let books = await client.book.findMany({
        where: {
            name: {
                equals: 'The Lost Tribe'
            }
        },
        select: {
            book_id: true
        }
    })

    console.table(books);
};

runTestSuite(run, client);