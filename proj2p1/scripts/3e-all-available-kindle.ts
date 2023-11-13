import { runTestSuite } from './util';
import { PrismaClient } from '@prisma/client';

const client = new PrismaClient();

const compileConditionalRule = (path: string) => ({
    $and: [
        { [path]: { $exists: true } },
        { [path]: { $ne: 'Unavailable' } },
    ]
});

const run = async () => {
    let books = await client.book.findRaw({
        filter: {
            $or: [
                compileConditionalRule('description.format.kindle'),
                compileConditionalRule('description.kindle'),
            ]
        },
        options: {
            projection: {
                id: true,
                name: true,
                'description.kindle': true,
                'description.format.kindle': true,
            }
        }
    })

    let b = Object.values(books);
    let b2 = b.map((ent: any) => ({
        _id: ent!._id,
        name: ent!.name,
        kindle: ent!.description.kindle || ent!.description.format.kindle,
    }))

    console.table(b2);
};

runTestSuite(run, client);