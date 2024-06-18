import axios from "axios";
import { useState } from "react";

interface Userdata {
  username: string;
  email: string;
  password: string;
}

const register: React.FC = () => {
  const redirect = (path: string) => {
    window.location.href = path;
  };
  const [data, setData] = useState<Userdata>({
    username: "",
    email: "",
    password: "",
  });

  const handleChange = (event: any) => {
    const name = event.target.name;
    const value = event.target.value;
    setData((values) => ({ ...values, [name]: value }));
  };

  const handleSubmit = (event: any) => {
    event.preventDefault();
    setData({
      username: "",
      email: "",
      password: "",
    });
  };

  async function request(data: Userdata) {
    const requete = await axios.post("http://localhost:5000/register", data);
    console.log(requete);
    return requete.data, redirect("http://localhost:5173/login");
  }

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label> Usersame :</label>
        <input
          type="text"
          id="username"
          name="username"
          value={data.username || ""}
          onChange={handleChange}
        ></input>

        <label> Email:</label>
        <input
          type="email"
          id="email"
          name="email"
          value={data.email || ""}
          onChange={handleChange}
        ></input>

        <label> Mot de passe:</label>
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
          onClick={(e) => request(data)}
        ></button>
      </form>
    </div>
  );
};

export default register;
