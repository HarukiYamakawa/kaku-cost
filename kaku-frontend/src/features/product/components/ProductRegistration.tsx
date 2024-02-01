"use client"
import React, { useState, useEffect} from 'react';
import { useRouter } from 'next/navigation';
import { Product } from '../types/Product';
import { useForm } from "react-hook-form";
import { yupResolver } from '@hookform/resolvers/yup';
import { registrationProductScheme } from '../validations/registrationProductScheme';
import { RegistrationFormData } from '../types/RegistrationFormData';
import { registrationProduct } from '../api/registrationProduct';
import { useRequireLogin } from '@/hooks/useRequireLogin';

export const ProductRegistration: React.FC = () => {

  const { register, handleSubmit, formState: { errors } } = useForm<RegistrationFormData>(
    {
      resolver: yupResolver(registrationProductScheme)
    }
  );

  const router = useRouter();

  const [error, setError] = useState<string>('');

  const handleRegistration = async (products: RegistrationFormData) => {
    try {
      const response = await registrationProduct(products);
      console.log(response);
      if (response.ok) {
        router.push('/');
      } else {
        const errorData = await response.json();
        setError(errorData.errors || 'Login failed');
      }
    } catch (error) {
      setError('Network error');
    }
  }

  return (
    <form onSubmit={handleSubmit(handleRegistration)}>
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
      <button type="submit">登録</button>
      {error && <p>{error}</p>}
    </form>
  )
}