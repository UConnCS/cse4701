type AsyncCloseable = () => Promise<void>;

export const runTestSuite = (runnable: Function, closeables: AsyncCloseable[]) => 
    runnable()
        .catch((err: Error) => console.error('ERROR: ', err))
        .finally(async () => await Promise.all(closeables.map(closeable => closeable())));
