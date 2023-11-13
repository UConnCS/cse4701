import { PrismaClient } from '@prisma/client';
import { runTestSuite } from './util';

const client = new PrismaClient();

const run = async () => {
    let count = await client.book.count({
        where: { image: { not: null } }
    });

    console.log('Total books with image:', count);
};

runTestSuite(run, client);