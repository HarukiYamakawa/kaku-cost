import useSWR from 'swr';
import { getAllProductList } from '../api/getAllProductList';

export const useGetAllProductList = () => {
  const { data, error } = useSWR(`/v1/products`, () => getAllProductList(), {
    // 更新、削除のデータ取得で利用するので、毎回再取得する
    revalidateOnFocus: false,
    dedupingInterval: 0,
  });

  return {
    productList: data,
    isError: error,
  };
};
