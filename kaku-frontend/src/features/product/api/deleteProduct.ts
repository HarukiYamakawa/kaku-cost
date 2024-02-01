export const deleteProduct = async (id: string) => {
  try{
    const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL + "/v1/products/" + id, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
      },
    });
    if (!response.ok) {
      throw new Error('サーバーエラーが発生しました');
    }
    return response;
  } catch (error) {
    console.error(error);
    throw error;
  }
}