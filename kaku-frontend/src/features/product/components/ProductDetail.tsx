'use client';
import { Product } from '../types/Product';
import {getProduct} from '../api/getProduct';
import React, { useState, useEffect} from 'react';
import { useRouter } from 'next/navigation';
import Image from 'next/image';
import {useGetProduct} from '../hooks/useGetProduct';

export const ProductDetail: React.FC<{id: string}> = ({id}) => {
    // const [product, setProduct] = useState<Product>({id: '', name: '', price: 0, description: '', image_url: ''});
    const [errors, setError] = useState<string>();
    const router = useRouter();


    const { product, isError } = useGetProduct(id);
    if (isError) return <div>failed to load</div>;
    if (!product) return <div>loading...</div>;

    return (
      <div>
        <h1>[商品詳細]</h1>
        <ul>
          <li key={product.id}>
            {product.name} - {product.price} <br />
            <Image src={product.image_url} alt={product.name} width="200" height="200" />
            {product.description}
          </li>
        </ul>
        <button onClick={() => router.back()}>戻る</button>
      </div>
    )
}
