import axios from "axios";
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

interface product {
  id: number;
  bubble_tea: string;
  user_id: number;
}

function get_one_products() {
  const [product, setUsers] = useState<product[]>([]);
  const [error, setError] = useState("");
  console.log(product);

  useEffect(() => {
    axios
      .get<product[]>(`http://localhost:5000/one_product/${id}/${params}`)
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
        {product.map((product) => (
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

export default get_one_products;
