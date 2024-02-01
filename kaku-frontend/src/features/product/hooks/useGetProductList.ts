import useSWR from 'swr';
import { getProductList } from '../api/getProductList';

export const useGetProductList = (page: number) => {
  const { data, error } = useSWR(`/v1/products/${page}`, () => getProductList(page), {
    // 10秒ごとにリクエストを送る
    refreshInterval: 10000,
    // 10秒はキャッシュ
    dedupingInterval: 10000,
  });

  return {
    productList: data,
    isError: error,
  };
};
