import axios from "axios";
import { jwtDecode } from "jwt-decode";
import { useEffect, useState } from "react";

interface Userdata {
  id: number;
  username: string;
  email: string;
  is_admin: boolean;
}

const Current_user: React.FC = () => {
  const [data, setData] = useState<Userdata>({
    username: "",
    email: "",
    id: 0,
    is_admin: false,
  });

  useEffect(() => {
    const fetchData = async () => {
      const token = localStorage.getItem("token");

      if (token) {
        const decoded = jwtDecode(token);
        const id = decoded.sub;

        try {
          const response = await axios.get<Userdata>(
            `http://localhost:5000/users/${id}`,
            {
              headers: { Authorization: `Bearer ${token}` },
            }
          );

          setData(response.data);
        } catch (error) {}
      }
    };

    fetchData();
  }, []);

  const is_admin = localStorage.setItem("is_admin", data.is_admin.toString());
  console.log(is_admin);

  return (
    <div>
      <p>Page profile</p>
      <p>There is your email: {data.email}</p>
      <p>There is your username: {data.username}</p>
      <p>There is your id: {data.id}</p>
    </div>
  );
};

export default Current_user;
