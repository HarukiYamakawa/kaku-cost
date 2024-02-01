import { ProductRegistration } from '@/features/product/components/ProductRegistration';
import { RequireLogin } from '@/components/layouts//RequireLogin';
const ProductRegistrationPage = () => {
  return (
    <div>
      <RequireLogin>
        <ProductRegistration />
      </RequireLogin>
    </div>
  );
}

export default ProductRegistrationPage;