"use client";
import { AuthContext } from '@/contexts/AuthContext';
import { useContext, useEffect, ReactNode } from 'react';
import { useRouter } from 'next/navigation';

export const RequireLogin: React.FC<{ children: ReactNode }> = ({ children }) => {
  const { isLogin } = useContext(AuthContext);
  const router = useRouter();

  useEffect(() => {
    if (!isLogin) {
      router.push('/');
    }
  }, []);

  if (isLogin) return <div> {children} </div>;
}

