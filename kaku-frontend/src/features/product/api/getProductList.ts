import { ProductListPagination } from '../types/ProductListPagination';
export const getProductList = async (page: number): Promise<ProductListPagination> => {
  try {
    const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL + `/v1/products?page=${page}`);
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