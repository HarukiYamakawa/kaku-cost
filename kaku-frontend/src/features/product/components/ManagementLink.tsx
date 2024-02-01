"use client";
import { AuthContext } from '@/contexts/AuthContext';
import Link from 'next/link';
import { useContext } from 'react';

export const ManagementLink: React.FC = () => {
  const { isLogin } = useContext(AuthContext);

  return (
    <div>
      {isLogin ? (
        <>
        <Link href="/product/management/registration">
          商品登録
        </Link>
        <Link href="/product/management/select-update">
          商品更新
        </Link>
        <Link href="/product/management/delete">
          商品削除
        </Link>
        </>
      ) : (
        <></>
      )}
    </div>
  );
}