import { ProductList } from '../../../features/product/components/ProductList';
const ProductListPage = async ({ params }: { params: { page: number } }) => {
  return (
    <div>
      <ProductList page={params.page} />
    </div>
  );
}

export default ProductListPage;