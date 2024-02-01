"use client"
import React, { useContext } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { AuthContext } from "@/contexts/AuthContext";
import { MouseEvent, useEffect } from "react";
import { signInConfirm } from "@/features/user-auth/api/signInConfirm";
import { signOut } from "@/features/user-auth/api/signOut";

export const AuthLink: React.FC = () => {
  const [error, setError] = React.useState<string>('');
  const { isLogin, setLoginEmail, setIsLogin, loginEmail} = useContext(AuthContext);
  const router = useRouter();

  const loginConfirm = async () => {
    const uid = localStorage.getItem("uid");
    try {
        if (uid) {
            const response = await signInConfirm();
            if (response.ok) {
              const data = await response.json();
              // 認証状態が有効であれば、ユーザー情報を返します
              setLoginEmail(data.data.email);
              setIsLogin(true);
            } else {
            // 認証状態が無効であれば、エラーを返します
            console.log("error");
            }
        } else {
            console.log("error");
        }
    }catch (error) {
        console.log(error);
    }
  }

  const handleLogout = async (event: MouseEvent<HTMLButtonElement>) => {
    event.preventDefault();
    try {
      const response = await signOut();

      if (response.ok) {
        const data = await response.json();
        // ログイン成功時の処理
        localStorage.setItem('access-token', '');
        localStorage.setItem('client', '');
        localStorage.setItem('uid', '');
        setLoginEmail("");
        setIsLogin(false);

        router.push('/');
        // 例: ユーザーをダッシュボードにリダイレクトするなど
      } else {
        const errorData = await response.json();
        setError(errorData.errors || 'Logout failed');
      }
    } catch (error) {
      setError('Network error');
    }
  };

  useEffect(() => {
    loginConfirm();
  }, []);

  if (isLogin) {
      return (
          <div className="text-sm font-medium">
              <nav>
                  <button onClick={handleLogout}>logout</button>
              </nav>
              {loginEmail}
          </div>
      );
  } else {
      return (
        <>
          <div className="text-sm font-medium">
              <nav>
                <Link href="/user-auth/sign-in">login</Link>
              </nav>
          </div>
          <div className="text-sm font-medium">
          <nav>
            <Link href="/user-auth/sign-up">sign up</Link>
          </nav>
        </div>
      </>
      );
  }
}