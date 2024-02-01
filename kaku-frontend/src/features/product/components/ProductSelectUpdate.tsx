"use client"
import React, { useEffect ,useState } from "react";
import {Product} from "../types/Product";
import { useRouter } from "next/navigation";
import { useGetAllProductList } from "../hooks/useGetAllProductList";
import  useSWR  from "swr";

export const ProductSelectUpdate = () => {
  const [id, setId] = useState<string>('');

  const router = useRouter();

  const { productList, isError } = useGetAllProductList();
  if (isError) return <div>failed to load</div>;
  if (!productList) return <div>loading...</div>;


  return (
    <div>
      <h1>商品更新</h1>
      <div>
        {productList.map((product) => (
          <div key={product.id}>
            <input type="radio" name="product" onChange={() => setId(product.id)} />
            <span>{product.name}</span>
          </div>
        ))}
      </div>
      <button onClick={() => router.push(`/product/management/update/${id}`)}>更新</button>
    </div>
  );
}