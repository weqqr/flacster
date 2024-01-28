async function request(endp: string): Promise<any> {
    const res = await fetch(endp);
    return await res.json();
}

export async function listFiles(): Promise<string[]> {
    const response = await request('http://localhost:1337/api/v1/library/files');
    return response['files'].map((x: string) => {
        const parts = x.split(/\\|\//);
        return parts[parts.length - 1];
    });
}
