"use client"
import React, { useState, FormEvent, useContext ,ChangeEvent} from 'react';
import { useRouter } from 'next/navigation';
import { AuthContext } from '@/contexts/AuthContext';
import { signUp } from '@/features/user-auth/api/signUp';
import { useForm } from "react-hook-form";
import { SignUpFormData } from '@/features/user-auth/types/SignUpFormData';
import { signUpFormSchema } from '@/features/user-auth/validations/signUpFormSchema';
import { yupResolver } from '@hookform/resolvers/yup';

export const SignUpForm: React.FC = () => {

  const { register, handleSubmit, formState: { errors } } = useForm<SignUpFormData>(
    {
      resolver: yupResolver(signUpFormSchema)
    }
  );

	//APIからエラーが返却された際のエラー情報を格納するstate
  const [error, setError] = useState<string>('');

	//利用するContextの呼び出し
  const { setLoginEmail, setIsLogin} = useContext(AuthContext);

	//ルーターの定義
  const router = useRouter();

  //SignUp用のAPIを呼び出すための関数
  const handleSignUp = async (data: SignUpFormData) => {
    try {
      const response = await signUp(data.name, data.email, data.password);

      if (response.ok) {
        const data = await response.json();
        // ログイン成功時の処理
        localStorage.setItem('access-token', response.headers.get('access-token') || '');
        localStorage.setItem('client', response.headers.get('client') || '');
        localStorage.setItem('uid', response.headers.get('uid') || '');
        setLoginEmail(data.data.email);
        setIsLogin(true);

        console.log('Logged in:', data);
        router.push('/');
        // 例: ユーザーをダッシュボードにリダイレクトするなど
      } else {
        const errorData = await response.json();
        setIsLogin(false);
        setError(errorData.errors || 'Login failed');
      }
    } catch (error) {
      setError('Network error');
    }
  }

  //SignUpフォームの定義
  return (
    <form onSubmit={handleSubmit(handleSignUp)}>
      <div>
        <label htmlFor="name">Name:</label>
        <input
          type="name"
          id="name"
          {...register('name', { required: true })}
        />
        <p>{errors.name?.message}</p>
      </div>
      <div>
        <label htmlFor="email">Email:</label>
        <input
          type="email"
          id="email"
          {...register('email', { required: true })}
        />
        <p>{errors.email?.message}</p>
      </div>
      <div>
        <label htmlFor="password">Password:</label>
        <input
          type="password"
          id="password"
          {...register('password', { required: true })}
        />
        <p>{errors.password?.message}</p>
      </div>
      <button type="submit">SignUp</button>
      {error && <p>{error}</p>}
    </form>
  );
};