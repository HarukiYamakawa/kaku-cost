"use client"
import React, { useEffect ,useState } from "react";
import {Product} from "../types/Product";
import { useRouter } from "next/navigation";
import { useGetAllProductList } from "../hooks/useGetAllProductList";
import { deleteProduct } from "../api/deleteProduct";

export const ProductDelete = () => {
  const [id, setId] = useState<string>('');

  const router = useRouter();

  const { productList, isError } = useGetAllProductList();
  if (isError) return <div>failed to load</div>;
  if (!productList) return <div>loading...</div>;

  const handleDelete = async (id: string) => {
    try {
      const response = await deleteProduct(id);
      if (response.ok) {
        router.push('/');
      }else{
        const errorData = await response.json();
        console.log(errorData.errors);
      }
    } catch (error) {
      console.log(error);
    }
  }


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
      <button onClick={() => handleDelete(id)}>削除</button>
    </div>
  );
}