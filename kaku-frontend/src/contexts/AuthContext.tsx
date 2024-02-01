"use client"
import React, { createContext, useState, ReactNode } from 'react';

// コンテキストの型定義
type AuthContextType = {
  loginEmail: string,
  setLoginEmail: React.Dispatch<React.SetStateAction<string>>,
  isLogin: boolean,
  setIsLogin: React.Dispatch<React.SetStateAction<boolean>>
}

// コンテキストの作成, 初期値を設定
export const AuthContext = createContext<AuthContextType>({
  loginEmail: '',
  setLoginEmail: () => '',
  isLogin: false,
  setIsLogin: () => false
});

// コンテキストで利用するStateの定義、コンテキストのProviderの定義
export const AuthContextProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [loginEmail, setLoginEmail] = useState<string>('');
  const [isLogin, setIsLogin] = useState<boolean>(false);

  return (
    <AuthContext.Provider value={{ loginEmail, setLoginEmail, isLogin, setIsLogin }}>
      {children}
    </AuthContext.Provider>
  );
};