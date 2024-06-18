import axios from "axios";
import { useEffect, useState } from "react";

interface User {
  password: string;
  email: string;
}
const redirect = (path: string) => {
  window.location.href = path;
};

const Login: React.FC = () => {
  console.log("coucou");
  const [error, setError] = useState("");

  const [data, setData] = useState<User>({
    email: "",
    password: "",
  });
  console.log(data);

  const handleChange = (event: any) => {
    const name = event.target.name;
    const value = event.target.value;
    setData((values) => ({ ...values, [name]: value }));
  };

  const handleSubmit = (event: any) => {
    event.preventDefault();
    setData({
      email: "",
      password: "",
    });
  };

  const request = async (data: User) => {
    try {
      const response = await axios.post("http://localhost:5000/login", data);
      if (response.status === 200) {
        const token = localStorage.setItem("token", response.data.access_token);
        console.log(token, "error on not error im there");
        return response.data.access_token, redirect("/current_user");
      }
    } catch (error) {
      console.error;
    }
  };

  return (
    <>
      {error && <p className="text-danger">{error}</p>}
      <div>
        <form onSubmit={handleSubmit}>
          <label> Email:</label>
          <input
            type="email"
            id="email"
            name="email"
            value={data.email || ""}
            onChange={handleChange}
          ></input>

          <label> password:</label>
          <input
            type="password"
            id="password"
            name="password"
            value={data.password || ""}
            onChange={handleChange}
          ></input>
          <button
            type="submit"
            value="Envoyer"
            onClick={(e: any) => {
              request(data);
            }}
          ></button>
        </form>
      </div>
    </>
  );
};

export default Login;
