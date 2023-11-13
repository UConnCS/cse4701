let book = await client.book.findFirst({
    where: { image: undefined },
    select: { name: true }
});

console.log('Book with no image:', book);