"use client";
import {Product} from '../types/Product';
import {useGetProductList} from '../hooks/useGetProductList';
import Link from 'next/link';
import Image from 'next/image';
import {useRouter} from 'next/navigation';

export const ProductList: React.FC<{page: number}> = ({page}) => {
    const router = useRouter();
    const { productList, isError } = useGetProductList(page);
    if (isError) return <div>failed to load</div>;
    if (!productList) return <div>loading...</div>;


    return (
      <div>
        <h1>[商品一覧]</h1>
        <ul>
          {productList.products.map((product: Product) => (
            <li key={product.id}>
              <Link href={`/product/${product.id}`}>
                {product.name} - {product.price}- {product.stock} <br />
                <Image src={product.image_url} alt={product.name} width="200" height="200" />
              </Link>
            </li>
          ))}
        </ul>
        {productList.meta.prev_page !== null && (
          <button onClick={() => router.push(`/product/list/${productList.meta.prev_page}`)}>前へ</button>
        )}
        {productList.meta.next_page !== null && (
          <button onClick={() => router.push(`/product/list/${productList.meta.next_page}`)}>次へ</button>
        )}
      </div>
    )
}