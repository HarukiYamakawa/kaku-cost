import useSWR from 'swr';
import { getProduct } from '../api/getProduct';

export const useGetProduct = (id: string) => {
  const { data, error } = useSWR(`/v1/products/${id}`, () => getProduct(id), {
    // 10秒ごとにリクエストを送る
    refreshInterval: 10000,
    // 10秒はキャッシュ
    dedupingInterval: 10000,
  });

  return {
    product: data,
    isError: error,
  };
};
