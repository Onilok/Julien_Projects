import axios from "axios";
import { useEffect, useState } from "react";

interface product {
  id: number;
  bubble_tea: string;
  user_id: number;
}

const  Get_all_products: React.FC = () => {
  const [products, setUsers] = useState<product[]>([]);
  const [error, setError] = useState("");
  console.log(products);

  useEffect(() => {
    axios
      .get<product[]>("http://localhost:5000/all_products")
      .then((res) => setUsers(res.data))
      .catch((err) => {
        setError(err.message);
      });
  }, []);

  return (
    <>
      {error && <p className="text-danger">{error}</p>}
      <p>products :</p>
      <ul>
        {products.map((product) => (
          <li key={product.id}>
            <p>id: {product.id}</p>
            <p>product: {product.bubble_tea}</p>
            <p>user_id: {product.user_id}</p>
          </li>
        ))}
      </ul>
    </>
  );
}

export default Get_all_products;
