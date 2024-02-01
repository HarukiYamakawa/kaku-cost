import { ProductSelectUpdate } from '@/features/product/components/ProductSelectUpdate';
import { RequireLogin } from '@/components/layouts//RequireLogin';

const ProductSelectUpdatePage = async () => {
    return (
        <div>
            <RequireLogin>
              <ProductSelectUpdate />
            </RequireLogin>
        </div>
    );
}

export default ProductSelectUpdatePage;