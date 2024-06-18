import axios from "axios";
import { useState, useEffect } from "react";
import { jwtDecode } from "jwt-decode";
import { useParams } from "react-router-dom";


interface Userdata {
  username: string;
  email: string;
  password: string;
}

export const Update_user: React.FC = () => {
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
  const token = localStorage.getItem("token");
  const decoded = jwtDecode(token!);

  const id = decoded.sub;
  const params = useParams<{ id_user: string; }>()
  function delete_user() {
    axios
      .delete(`http://localhost:5000/user_delete/${id}/${params}`, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((response) => {
        console.log("Request successful:", response.data);
      })
      .catch((error) => {
        console.error("Error in request:", error);
      });
  }
  function request(data: Userdata) {
    axios
      .put(`http://localhost:5000/user_update/${id}`, data, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((response) => {
        console.log("Request successful:", response.data);
        redirect("/current_user");
      })
      .catch((error) => {
        console.error("Error in request:", error);
      });
  }

  return (
    <div>
      <label> you have to change all of input </label>
      <form onSubmit={handleSubmit}>
        <label> change your Usersame :</label>
        <input
          type="text"
          id="username"
          name="username"
          value={data.username}
          onChange={handleChange}
        ></input>

        <label> change your email Email:</label>
        <input
          type="email"
          id="email"
          name="email"
          value={data.email}
          onChange={handleChange}
        ></input>

        <label> change your password:</label>
        <input
          type="password"
          id="password"
          name="password"
          value={data.password}
          onChange={handleChange}
        ></input>
        <button
          type="submit"
          value="Envoyer"
          onClick={(e: any) => request(data)}
        ></button>

        <p>click here to delete your user</p>
        <button
          type="submit"
          value="Envoyer"
          onClick={(e: any) => delete_user()}
        ></button>
      </form>
    </div>
  );
}
