export async function fetchBufferImage(src: string) {
  const response = await fetch(src);
  const image = await response.arrayBuffer();

  return image;
}
