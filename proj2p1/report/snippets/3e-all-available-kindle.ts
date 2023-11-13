const compileConditionalRule = (path: string) => ({
    $and: [
        { [path]: { $exists: true } },
        { [path]: { $ne: 'Unavailable' } },
    ]
});

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

console.table(books);