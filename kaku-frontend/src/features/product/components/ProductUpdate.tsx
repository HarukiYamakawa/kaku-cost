"use client"
import React, { useState, useEffect} from 'react';
import { useRouter } from 'next/navigation';
import { Product } from '../types/Product';
import { useForm } from "react-hook-form";
import { yupResolver } from '@hookform/resolvers/yup';
import { updateProductScheme } from '../validations/updateProductScheme';
import { UpdateFormData } from '../types/UpdateFormData';
import { updateProduct } from '../api/updateProduct';
import { useRequireLogin } from '@/hooks/useRequireLogin';

export const ProductUpdate: React.FC<{id: string}> = ({id}) => {
  
  const { register, handleSubmit, formState: { errors } } = useForm<UpdateFormData>(
    {
      resolver: yupResolver(updateProductScheme)
    }
  );

  const router = useRouter();

  const [error, setError] = useState<string>('');

  const handleUpdate = async (products: UpdateFormData) => {
    try {
      const response = await updateProduct(id, products);
      console.log(response);
      if (response.ok) {
        router.push('/');
      } else {
        const errorData = await response.json();
        setError(errorData.errors);
      }
    } catch (error) {
      setError('Network error');
    }
  }

  return (
    <form onSubmit={handleSubmit(handleUpdate)}>
      <div>
        <label htmlFor="name">Name:</label>
        <input
          id="name"
          type="text"
          {...register("name")}
        />
        <p>{errors.name?.message}</p>
      </div>
      <div>
        <label htmlFor="price">Price:</label>
        <input
          id="price"
          type="number"
          {...register("price")}
        />
        <p>{errors.price?.message}</p>
      </div>
      <div>
        <label htmlFor="stock">Stock:</label>
        <input
          id="stock"
          type="number"
          {...register("stock")}
        />
        <p>{errors.stock?.message}</p>
      </div>
      <div>
        <label htmlFor="description">Description:</label>
        <input
          id="description"
          type="text"
          {...register("description")}
        />
        <p>{errors.description?.message}</p>
      </div>
      <div>
        <label htmlFor="image_url">Image_url:</label>
        <input
          id="image_url"
          type="text"
          {...register("image_url")}
        />
        <p>{errors.image_url?.message}</p>
      </div>
      <button type="submit">更新</button>
      <div>{error}</div>
    </form>
  )
}

export default ProductUpdate;