import { PrismaClient } from '@prisma/client';

export const runTestSuite = (runnable: Function, client: PrismaClient) => 
    runnable()
        .catch((err: Error) => console.error('ERROR: ', err))
        .finally(async () => await client.$disconnect());
