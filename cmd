ฉันต้องการสร้าง generative ai ช่วยฉันวางแผนและสร้างตาม Flow นี้หน่อย คุยกันก่อนนะ.
flow:
1. Frontend (ReactJS) - UI สำหรับ user interact
2. Agent (Python + Langchain) - หัวใจหลักที่จัดการ logic และ tool calling
3. MCP Server (Python + PostgreSQL + SSE) - ระบบจัดการข้อมูลและ real-time updates
4. OpenRouter LLM - External LLM service สำหรับ AI responses
มีคำถามไม่กี่ข้อที่อยากคุยก่อนเริ่มวางแผน:
ด้าน Functionality: * AI นี้จะทำหน้าที่ ตอบคำถามทางธุรกิจด้วยการ calling tool postgresql เพื่อนำข้อมูลไปวิเคราะห์ * Tool calling จะเรียกใช้ postgresql ให้คุณคิดให้ว่าต้องใช้ tool อะไรบ้างเลย ด้านเทคนิค: * PostgreSQL เก็บข้อมูลสองตาราง Customers, Orders โดยให้คุณสร้าง container และ initial data ให้เลย * 
SSE (Server-Sent Events) จะใช้สำหรับ streaming responses * OpenRouter คุณมี API keyแล้ว ให้คุณใช้เป็น ENV Param ไว้ที่ docker compose เดี๋ยวset เอง * ใช้ websocket ระหว่าง front end กับ agent api ด้วยนะ 
ด้าน Infrastructure: * คิดจะ deploy ที่ docker * มี budget หรือข้อจำกัดด้านทรัพยากรไหม? => ใช้ model free
Architecture Overview

[ReactJS Frontend] 
   ↕️ (WebSocket)
[Python Agent API] 
   ↕️ (HTTP/SSE)
[MCP Server + PostgreSQL]
   ↗️ (Tool Calls)
[OpenRouter LLM API]
Tools ที่ต้องสร้างสำหรับ PostgreSQL:
1. get_customer_info - ดึงข้อมูลลูกค้า
2. get_customer_orders - ดึงคำสั่งซื้อของลูกค้า
3. analyze_sales_trends - วิเคราะห์แนวโน้มการขาย
4. get_top_customers - หาลูกค้า VIP
5. calculate_revenue - คำนวณรายได้
6. product_performance - วิเคราะห์ผลิตภัณฑ์
7. execute_custom_query - รัน custom SQL (สำหรับ complex analysis)
Database Schema (ตัวอย่าง):

sql
-- Customers table
customers (id, name, email, phone, created_at, city, country)

-- Orders table  
orders (id, customer_id, product_name, quantity, price, order_date, status)
Tech Stack Summary:
* Frontend: ReactJS + WebSocket client
* Agent: Python + FastAPI + Langchain + WebSocket server
* MCP Server: Python + FastAPI + asyncpg + SSE
* Database: PostgreSQL 15 in Docker
* LLM: OpenRouter (free models เช่น llama-3.1-8b-instant)
* Deployment: Docker Compose
สร้างทั้งหมดใน D:\Workspaces\LLM_Agent_C ต่อจากของเดิมได้เลย
