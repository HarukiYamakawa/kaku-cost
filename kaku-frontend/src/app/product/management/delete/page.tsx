import { ProductDelete } from "@/features/product/components/ProductDelete";
import { RequireLogin } from '@/components/layouts//RequireLogin';
const ProductDeletePage = async () => {
  return (
    <div>
      <RequireLogin>
        <ProductDelete />
      </RequireLogin>
    </div>
  );
}

export default ProductDeletePage;