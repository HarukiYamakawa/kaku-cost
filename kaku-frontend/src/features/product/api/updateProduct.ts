import { UpdateFormData} from "@/features/product/types/UpdateFormData";

export const updateProduct = async (id: string, product: UpdateFormData) => {
  try {
    const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL + '/v1/products/' + id, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        product: product
      }),
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
