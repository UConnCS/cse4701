import { runTestSuite } from './util';
import { BookJson, BookMap } from './types';
import { PrismaClient } from '@prisma/client';
import { readFileSync, readdirSync } from 'fs';

const client = new PrismaClient();

const run = async () => {
    let files = readdirSync('./data')
        .filter(file => file.endsWith('.json'))
        .map(file => `./data/${file}`)
        .map(path => readFileSync(path, 'utf-8'))
        .map(json => JSON.parse(json))
        .map(payload => payload as BookJson);

    let images = readdirSync('./data')
        .filter(file => file.endsWith('.jpg'))
        .map(file => `./data/${file}`)
        .map(path => ({
            bookId: path.split(/(B\d+)/g)[1],
            blob: readFileSync(path)
        }));

    let bookMap: BookMap = files.reduce((acc, book) => {
        acc[book.id] = { book };

        let image = images.find(image => image.bookId === book.id);
        if (image) acc[book.id].image = image.blob;
        
        return acc;
    }, {} as BookMap);
    
    let records = await Promise.all(
        Object.keys(bookMap).map(async bookId => {
            let { book, image } = bookMap[bookId];
            let { author, ...rest } = book;
    
            return await client.book.create({
                data: {
                    name: book.bookname,
                    book_id: bookId,
                    image,
                    description: rest,
                }
            });
        })
    );

    console.log('Created records:', records);
};

runTestSuite(run, client);