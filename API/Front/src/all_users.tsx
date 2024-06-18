import axios from "axios";
import { useEffect, useState } from "react";

interface User {
  id: number;
  username: string;
  email: string;
}

const Get_all_users : React.FC = () =>{
  const [users, setUsers] = useState<User[]>([]);
  const [error, setError] = useState("");
  console.log(users);

  useEffect(() => {
    axios
      .get<User[]>("http://localhost:5000/all_users")
      .then((res) => setUsers(res.data))
      .catch((err) => {
        setError(err.message);
      });
  }, []);

  return (
    <>
      {error && <p className="text-danger">{error}</p>}
      <p>Utilisateurs :</p>
      <ul>
        {users.map((user) => (
          <li key={user.id}>
            <p>ID: {user.id}</p>
            <p>Username: {user.username}</p>
            <p>Email: {user.email}</p>
          </li>
        ))}
      </ul>
    </>
  );
}

export default Get_all_users;
