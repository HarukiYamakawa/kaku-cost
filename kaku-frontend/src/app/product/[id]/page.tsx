import { ProductDetail } from '../../../features/product/components/ProductDetail';
const ProductDetailPage = async ({ params }: { params: { id: string } }) => {
    return (
        <div>
            <ProductDetail id={params.id} />
        </div>
    );
}

export default ProductDetailPage;