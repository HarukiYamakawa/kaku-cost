import { Product } from './Product';
import { Pagination } from '@/types/Pagination';
export type ProductListPagination = {
  products: Product[];
  meta: Pagination;
};
