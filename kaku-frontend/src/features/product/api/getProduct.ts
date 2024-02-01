import { Product } from '../types/Product';

export const getProduct = async (id: string): Promise<Product> => {
  try {
    const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL + '/v1/products/' + id);
    if (!response.ok) {
      throw new Error('サーバーエラーが発生しました');
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}