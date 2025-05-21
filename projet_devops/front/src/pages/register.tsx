import { useState } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/register.css"; // Assurez-vous que ce fichier est bien inclus

const Register = () => {
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    password: "",
  });

  const [message, setMessage] = useState("");
  const navigate = useNavigate();

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const response = await fetch("http://localhost:5000/register", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      const data = await response.json();

      if (response.ok) {
        setMessage("Inscription réussie ! Redirection en cours...");

        // Redirection vers la page de connexion après 2 secondes
        setTimeout(() => navigate("/login"), 2000);
      } else {
        setMessage(data.message || "Une erreur est survenue.");
      }
    } catch (error) {
      setMessage("Erreur de connexion au serveur.");
    }
  };

  return (
    <div className="register-container">
      <div className="register-box">
        <h1>Inscription</h1>
        {message && (
          <div
            className={`flash-message ${
              message.includes("réussie") ? "success" : "error"
            }`}
          >
            {message}
          </div>
        )}

        <form onSubmit={handleSubmit}>
          <input
            type="text"
            name="username"
            placeholder="Nom d'utilisateur"
            value={formData.username}
            onChange={handleChange}
            required
          />
          <input
            type="email"
            name="email"
            placeholder="Email"
            value={formData.email}
            onChange={handleChange}
            required
          />
          <input
            type="password"
            name="password"
            placeholder="Mot de passe"
            value={formData.password}
            onChange={handleChange}
            required
          />
          <button type="submit">S'inscrire</button>
        </form>

        <p className="register-link">
          Déjà un compte ? <a href="/login">Connectez-vous</a>
        </p>
      </div>
    </div>
  );
};

export default Register;
