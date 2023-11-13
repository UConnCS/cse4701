let count = await client.book.count({
    where: {
        image: { not: null }
    }
});

console.log('Total books with image:', count);