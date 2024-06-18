import axios from "axios";
import { useEffect, useState } from "react";
import { jwtDecode } from "jwt-decode";

interface product {
  id: number;
  bubble_tea: string;
  user_id: number;
}

const User_product : React.FC = () => {
  const [products, setProduct] = useState<product[]>([]);
  const [error, setError] = useState("");
  console.log(products);
  const token = localStorage.getItem("token");
  const decoded = jwtDecode(token!);

  const id = decoded.sub;

  useEffect(() => {
    axios
      .get<product[]>(`http://localhost:5000/user_product/${id}`, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((res) => setProduct(res.data))
      .catch((err) => {
        setError(err.message);
      });
  }, []);

  return (
    <>
      {/* {error && <p className="text-danger">{error}</p>} */}
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

export default User_product;
