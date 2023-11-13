// Enumerate all JSON files in the data directory and get their contents.
let files = readdirSync('./data')
    .filter(file => file.endsWith('.json'))
    .map(file => `./data/${file}`)
    .map(path => readFileSync(path, 'utf-8'))
    .map(json => JSON.parse(json))
    .map(payload => payload as BookJson);

// Enumerate all JPG files in the data directory and get their binary contents.
let images = readdirSync('./data')
    .filter(file => file.endsWith('.jpg'))
    .map(file => `./data/${file}`)
    .map(path => ({
        bookId: path.split(/(B\d+)/g)[1],
        blob: readFileSync(path)
    }));

// Coalesce the books and images into a map of book ID to book and image.
let bookMap: BookMap = files.reduce((acc, book) => {
    acc[book.id] = { book };

    let image = images.find(image => image.bookId === book.id);
    if (image) acc[book.id].image = image.blob;

    return acc;
}, {} as BookMap);

// Create a database record for each book in the above map.
let records = await Promise.all(
    Object.keys(bookMap).map(async bookId => {
        let { book, imageBlob } = bookMap[bookId];
        let { author, ...rest } = book;

        return await client.book.create({
            data: {
                name: book.bookname,
                book_id: bookId,
                image: imageBlob,
                description: rest,
            }
        });
    })
);