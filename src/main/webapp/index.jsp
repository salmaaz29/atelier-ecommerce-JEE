<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopMaroc - Votre Boutique en Ligne Premium</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #667eea;
            --secondary: #764ba2;
            --accent: #f093fb;
            --dark: #2d3748;
            --light: #f8fafc;
            --success: #48bb78;
            --text: #2d3748;
            --text-light: #718096;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.7;
            color: var(--text);
            overflow-x: hidden;
            background: var(--light);
        }

        /* Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 1.2rem 0;
            box-shadow: 0 4px 30px rgba(0,0,0,0.08);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--primary);
            font-size: 1.8rem;
            font-weight: 800;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .logo:hover {
            transform: translateY(-2px);
        }

        .logo-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-btn {
            padding: 0.8rem 2rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: inline-block;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .nav-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .nav-btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border: none;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: transparent;
            border: 2px solid var(--primary);
            color: var(--primary);
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.5);
        }

        .btn-secondary:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            color: white;
            padding: 12rem 2rem 8rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background:
                    radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.2) 0%, transparent 50%);
            animation: float 8s ease-in-out infinite;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 900px;
            margin: 0 auto;
        }

        .hero h1 {
            font-size: 4.5rem;
            margin-bottom: 1.5rem;
            animation: slideUp 1s ease-out;
            font-weight: 800;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            line-height: 1.2;
        }

        .hero p {
            font-size: 1.4rem;
            margin-bottom: 3rem;
            opacity: 0.95;
            animation: slideUp 1s 0.2s both;
            line-height: 1.8;
            font-weight: 300;
        }

        .hero-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            animation: slideUp 1s 0.4s both;
        }

        .hero-btn {
            padding: 1.3rem 3.5rem;
            font-size: 1.2rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            position: relative;
            overflow: hidden;
        }

        .hero-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.6s;
        }

        .hero-btn:hover::before {
            left: 100%;
        }

        .hero-btn-white {
            background: white;
            color: var(--primary);
            border: 2px solid white;
        }

        .hero-btn-outline {
            background: transparent;
            border: 2px solid rgba(255,255,255,0.8);
            color: white;
            backdrop-filter: blur(10px);
        }

        .hero-btn:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(0,0,0,0.4);
        }

        .hero-btn-white:hover {
            background: rgba(255,255,255,0.95);
        }

        .hero-btn-outline:hover {
            background: rgba(255,255,255,0.1);
            border-color: white;
        }

        /* Features Section */
        .features {
            padding: 8rem 2rem;
            background: var(--light);
            position: relative;
        }

        .features::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--primary), transparent);
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .section-title {
            text-align: center;
            font-size: 3.2rem;
            margin-bottom: 5rem;
            color: var(--text);
            position: relative;
            font-weight: 800;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 5px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            border-radius: 3px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 3rem;
        }

        .feature-card {
            background: white;
            padding: 3.5rem 2.5rem;
            border-radius: 25px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.08);
            text-align: center;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            transform: scaleX(0);
            transition: transform 0.5s;
        }

        .feature-card:hover {
            transform: translateY(-20px) scale(1.02);
            box-shadow: 0 25px 60px rgba(102, 126, 234, 0.15);
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2.5rem;
            color: white;
            font-size: 3rem;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
            position: relative;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.15) rotate(10deg);
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.6);
        }

        .feature-card h3 {
            margin-bottom: 1.5rem;
            color: var(--text);
            font-size: 1.6rem;
            font-weight: 700;
        }

        .feature-card p {
            color: var(--text-light);
            line-height: 1.8;
            font-size: 1.1rem;
        }

        /* Testimonials Section */
        .testimonials {
            padding: 8rem 2rem;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            position: relative;
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
            gap: 3rem;
            margin-top: 5rem;
        }

        .testimonial-card {
            background: white;
            padding: 3rem;
            border-radius: 25px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            position: relative;
            border: 1px solid rgba(255,255,255,0.3);
        }

        .testimonial-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
        }

        .testimonial-header {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .testimonial-avatar {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            font-weight: bold;
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
            flex-shrink: 0;
        }

        .testimonial-info h4 {
            color: var(--text);
            margin-bottom: 0.5rem;
            font-size: 1.4rem;
            font-weight: 700;
        }

        .stars {
            color: #ffc107;
            font-size: 1.3rem;
            letter-spacing: 2px;
        }

        .testimonial-text {
            color: var(--text-light);
            font-style: italic;
            line-height: 1.8;
            font-size: 1.15rem;
            position: relative;
            padding-left: 2rem;
        }

        .testimonial-text::before {
            content: '"';
            position: absolute;
            left: 0;
            top: -15px;
            font-size: 4rem;
            color: var(--primary);
            opacity: 0.3;
            font-family: Georgia, serif;
        }

        /* CTA Section */
        .cta {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            color: white;
            padding: 8rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .cta::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background:
                    radial-gradient(circle at 10% 20%, rgba(120, 119, 198, 0.4) 0%, transparent 50%),
                    radial-gradient(circle at 90% 80%, rgba(255, 119, 198, 0.4) 0%, transparent 50%);
            animation: float 10s ease-in-out infinite;
        }

        .cta-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            margin: 0 auto;
        }

        .cta h2 {
            font-size: 4rem;
            margin-bottom: 2rem;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            font-weight: 800;
            line-height: 1.2;
        }

        .cta p {
            font-size: 1.5rem;
            margin-bottom: 3rem;
            opacity: 0.95;
            line-height: 1.8;
            font-weight: 300;
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--dark) 0%, #1a202c 100%);
            color: white;
            padding: 5rem 2rem 2rem;
            position: relative;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--primary), transparent);
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 4rem;
            margin-bottom: 4rem;
        }

        .footer-section h3 {
            margin-bottom: 1.8rem;
            color: var(--primary);
            font-size: 1.6rem;
            position: relative;
            padding-bottom: 0.8rem;
            font-weight: 700;
        }

        .footer-section h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--primary);
            border-radius: 2px;
        }

        .footer-section p {
            color: #cbd5e0;
            line-height: 1.8;
            font-size: 1.1rem;
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section ul li {
            margin-bottom: 1rem;
        }

        .footer-section a {
            color: #cbd5e0;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .footer-section a:hover {
            color: white;
            transform: translateX(8px);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 3rem;
            border-top: 1px solid #4a5568;
            color: #cbd5e0;
            font-size: 1.1rem;
        }

        /* Animations */
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(60px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translate(0, 0) rotate(0deg);
            }
            33% {
                transform: translate(-10px, -10px) rotate(1deg);
            }
            66% {
                transform: translate(10px, 5px) rotate(-1deg);
            }
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .hero h1 {
                font-size: 3.5rem;
            }

            .cta h2 {
                font-size: 3.2rem;
            }
        }

        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 1.5rem;
            }

            .hero {
                padding: 10rem 1rem 6rem;
                min-height: auto;
            }

            .hero h1 {
                font-size: 2.8rem;
            }

            .hero p {
                font-size: 1.2rem;
            }

            .hero-buttons {
                flex-direction: column;
                align-items: center;
                gap: 1.2rem;
            }

            .section-title {
                font-size: 2.5rem;
            }

            .features-grid, .testimonials-grid {
                grid-template-columns: 1fr;
            }

            .feature-card, .testimonial-card {
                padding: 2.5rem 2rem;
            }

            .cta h2 {
                font-size: 2.5rem;
            }

            .cta p {
                font-size: 1.2rem;
            }
        }

        @media (max-width: 480px) {
            .hero h1 {
                font-size: 2.2rem;
            }

            .hero p {
                font-size: 1.1rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .nav-btn, .hero-btn {
                padding: 1rem 2rem;
                font-size: 1rem;
                width: 100%;
                max-width: 280px;
            }

            .feature-icon {
                width: 90px;
                height: 90px;
                font-size: 2.2rem;
            }
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar">
    <div class="nav-container">
        <a href="<%= request.getContextPath() %>/" class="logo">
            <div class="logo-icon">SM</div>
            <span>ShopMaroc</span>
        </a>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/user?action=login" class="nav-btn btn-secondary">Connexion</a>
            <a href="<%= request.getContextPath() %>/user?action=register" class="nav-btn btn-primary">S'inscrire</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1>L'Excellence du Shopping en Ligne</h1>
        <p>Découvrez une expérience shopping révolutionnaire avec ShopMaroc. Des produits premium, un service exceptionnel et des avantages exclusifs vous attendent.</p>
        <div class="hero-buttons">
            <a href="<%= request.getContextPath() %>/user?action=register" class="hero-btn hero-btn-white">
                🚀 Commencer l'aventure
            </a>
            <a href="#features" class="hero-btn hero-btn-outline">
                ✨ Découvrir les avantages
            </a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features" id="features">
    <div class="container">
        <h2 class="section-title">L'Excellence ShopMaroc</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">🎯</div>
                <h3>Qualité Premium</h3>
                <p>Chaque produit est rigoureusement sélectionné pour vous offrir une qualité exceptionnelle et une satisfaction garantie.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🚀</div>
                <h3>Innovation Continue</h3>
                <p>Soyez les premiers à découvrir nos nouveautés exclusives et produits tendance ajoutés quotidiennement.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">💰</div>
                <h3>Prix Imbattables</h3>
                <p>Profitez des meilleurs prix du marché avec des offres exclusives réservées à notre communauté.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📦</div>
                <h3>Livraison Éclair</h3>
                <p>Recevez vos commandes en un temps record grâce à notre réseau de livraison ultra-rapide.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔒</div>
                <h3>Sécurité Totale</h3>
                <p>Vos transactions sont protégées par les systèmes de sécurité les plus avancés du marché.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">💎</div>
                <h3>Service Premium</h3>
                <p>Notre équipe dédiée vous accompagne 24h/24 pour une expérience shopping parfaite.</p>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="testimonials">
    <div class="container">
        <h2 class="section-title">Ils Nous Font Confiance</h2>
        <div class="testimonials-grid">
            <div class="testimonial-card">
                <div class="testimonial-header">
                    <div class="testimonial-avatar">AE</div>
                    <div class="testimonial-info">
                        <h4>Ahmed El Amrani</h4>
                        <div class="stars">★★★★★</div>
                    </div>
                </div>
                <p class="testimonial-text">
                    Une expérience shopping exceptionnelle ! La qualité des produits dépasse toutes mes attentes. ShopMaroc a révolutionné ma façon d'acheter en ligne.
                </p>
            </div>
            <div class="testimonial-card">
                <div class="testimonial-header">
                    <div class="testimonial-avatar">SB</div>
                    <div class="testimonial-info">
                        <h4>Salma Benjelloun</h4>
                        <div class="stars">★★★★★</div>
                    </div>
                </div>
                <p class="testimonial-text">
                    Le service client est tout simplement remarquable. On se sent vraiment accompagné à chaque étape. Devenue cliente fidèle depuis 6 mois !
                </p>
            </div>
            <div class="testimonial-card">
                <div class="testimonial-header">
                    <div class="testimonial-avatar">YK</div>
                    <div class="testimonial-info">
                        <h4>Youssef Khalil</h4>
                        <div class="stars">★★★★★</div>
                    </div>
                </div>
                <p class="testimonial-text">
                    Impressionné par la rapidité et la qualité du service. Mes commandes arrivent toujours en parfait état. Je recommande vivement ShopMaroc !
                </p>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta">
    <div class="cta-content">
        <h2>Prêt à Transformer Votre Expérience Shopping ?</h2>
        <p>Rejoignez notre communauté exclusive et accédez à un univers de produits premium, d'offres spéciales et d'un service personnalisé.</p>
        <a href="<%= request.getContextPath() %>/user?action=register" class="hero-btn hero-btn-white">
            💫 Créer mon compte gratuit
        </a>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>ShopMaroc</h3>
            <p>Votre destination shopping premium au Maroc. Excellence, innovation et satisfaction garantie pour chaque expérience d'achat.</p>
        </div>
        <div class="footer-section">
            <h3>Navigation</h3>
            <ul>
                <li><a href="<%= request.getContextPath() %>/">🏠 Accueil</a></li>
                <li><a href="#features">✨ Avantages</a></li>
                <li><a href="<%= request.getContextPath() %>/user?action=login">🔐 Connexion</a></li>
                <li><a href="<%= request.getContextPath() %>/user?action=register">🚀 S'inscrire</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>Service Client</h3>
            <ul>
                <li><a href="#">📞 Contactez-nous</a></li>
                <li><a href="#">❓ FAQ</a></li>
                <li><a href="#">🚚 Livraison</a></li>
                <li><a href="#">🔄 Retours</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>Informations</h3>
            <ul>
                <li><a href="#">🏢 À propos</a></li>
                <li><a href="#">📄 Conditions</a></li>
                <li><a href="#">🔒 Confidentialité</a></li>
                <li><a href="#">⚖️ Mentions légales</a></li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2025 ShopMaroc. Tous droits réservés. | Fait avec ❤️ par Saly</p>
    </div>
</footer>
</body>
</html>