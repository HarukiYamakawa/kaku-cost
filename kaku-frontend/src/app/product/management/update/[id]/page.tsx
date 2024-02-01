import { ProductUpdate } from '@/features/product/components/ProductUpdate';
import { RequireLogin } from '@/components/layouts//RequireLogin';
const ProductUpdatePage = async ({ params }: { params: { id: string } }) => {
    return (
        <div>
            <RequireLogin>
             <ProductUpdate id={params.id} />
            </RequireLogin>
        </div>
    );
}

export default ProductUpdatePage;