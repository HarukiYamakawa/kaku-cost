import Image from 'next/image'
import Link from 'next/link'
export default function Home() {
  return (
    <div className="flex flex-col h-screen pb-32">
      <div className="m-auto text-center">
        <div className="text-6xl font-bold text-green-600">
          KAKU
        </div>
        <p className="text-gray-700">
          Kaku no ECsite
        </p>
      </div>
    </div>
  )
}
