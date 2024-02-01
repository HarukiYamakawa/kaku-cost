"use client"
import React, { useState, FormEvent, useContext ,ChangeEvent} from 'react';
import { useRouter } from 'next/navigation';
import { AuthContext } from '@/contexts/AuthContext';
import { signIn } from '@/features/user-auth/api/signIn';
import { useForm } from "react-hook-form";
import { SignInFormData } from '@/features/user-auth/types/SignInFormData';
import { signInFormSchema } from '@/features/user-auth/validations/signInFormSchema';
import { yupResolver } from '@hookform/resolvers/yup';

export const SignInForm: React.FC = () => {
  
    const { register, handleSubmit, formState: { errors } } = useForm<SignInFormData>(
      {
        resolver: yupResolver(signInFormSchema)
      }
    );
  
    //APIからエラーが返却された際のエラー情報を格納するstate
    const [error, setError] = useState<string>('');
  
    //利用するContextの呼び出し
    const { setLoginEmail, setIsLogin} = useContext(AuthContext);
  
    //ルーターの定義
    const router = useRouter();
  
    //SignUp用のAPIを呼び出すための関数
    const handleSignIn = async (data: SignInFormData) => {
      try {
        const response = await signIn(data.email, data.password);
  
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
  
    //SignInフォームの定義
    return (
      <form onSubmit={handleSubmit(handleSignIn)}>
        <div>
          <label htmlFor="email">Email:</label>
          <input
            id="email"
            type="email"
            {...register("email")}
          />
          {errors.email && <p>{errors.email.message}</p>}
        </div>
        <div>
          <label htmlFor="password">Password:</label>
          <input
            id="password"
            type="password"
            {...register("password")}
          />
          {errors.password && <p>{errors.password.message}</p>}
        </div>
        <button type="submit">Sign In</button>
        {error && <p>{error}</p>}
      </form>
    );
}
